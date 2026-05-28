import os
import json
# from openai import OpenAI
from dotenv import load_dotenv
from groq import Groq

load_dotenv()


# client = OpenAI(
#     base_url="https://openrouter.ai/api/v1",
#     api_key=os.getenv("OPENROUTER_API_KEY"),
# )


api_key = os.getenv("apiKey")
grokapi=os.getenv("grokapi")
client = Groq(api_key=os.getenv("grokapi"))


def generate_meal_plan(profile_data):

    prompt = f"""
    You are an AI meal planner.

    Generate a 7-day meal plan.

    User Profile:
    {profile_data}

    Rules:
    - Return ONLY valid JSON
    - No markdown
    - Include breakfast, lunch, dinner
    - Keep meals realistic
    - Respect diet_type and allergies

    Example format:
    {{
      "monday": {{
        "breakfast": "...",
        "lunch": "...",
        "dinner": "..."
      }}
    }}
    """

    completion = client.chat.completions.create(
        model="llama-3.1-8b-instant",
        messages=[
            {
                "role": "user",
                "content": prompt
            }
        ],
        temperature=0.7
    )

    response_text = completion.choices[0].message.content.strip()

    try:
        return json.loads(response_text)
    except json.JSONDecodeError:
        start = response_text.find("{")
        end = response_text.rfind("}")
        if start != -1 and end != -1 and end > start:
            return json.loads(response_text[start:end + 1])
        raise