from services.llm_service import (
    generate_json_response,
)


def planner_agent(state):

    user_profile = state["user_profile"]

    prompt = f"""
    Create a structured 7-day meal plan.

    Return ONLY valid JSON.

    Format:
    {{
      "meals": [
        {{
          "day": "Monday",
          "breakfast": "...",
          "lunch": "...",
          "dinner": "..."
        }}
      ]
    }}

    User Profile:
    {user_profile}
    """

    result = generate_json_response(
        prompt
    )

    return {
        "meal_plan": result
    }