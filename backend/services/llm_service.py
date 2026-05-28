import os
import json
from groq import Groq

client = Groq(
    api_key=os.getenv("grokapi")
)

MODEL_NAME = "llama-3.1-8b-instant"


def generate_llm_response(prompt: str):

    completion = client.chat.completions.create(
        model=MODEL_NAME,
        messages=[
            {
                "role": "user",
                "content": prompt
            }
        ],
        temperature=0.7,
    )

    return (
        completion
        .choices[0]
        .message
        .content
    )


def generate_meal_plan(user_profile):

    prompt = f"""
    Create a weekly meal plan.

    User Profile:
    {user_profile}

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

    response_text = generate_llm_response(prompt)
    try:
        return json.loads(response_text)
    except json.JSONDecodeError:
        start = response_text.find("{")
        end = response_text.rfind("}")
        if start != -1 and end != -1 and end > start:
            return json.loads(response_text[start:end + 1])
        raise
    return 

import json


def generate_json_response(prompt: str):

    completion = client.chat.completions.create(
        model=MODEL_NAME,
        messages=[
            {
                "role": "user",
                "content": prompt
            }
        ],
        temperature=0.3,
        response_format={
            "type": "json_object"
        }
    )

    content = (
        completion
        .choices[0]
        .message
        .content
    )

    return json.loads(content)