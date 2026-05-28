from services.llm_service import (
    generate_json_response,
)


def grocery_agent(state):

    meal_plan = state[
        "validated_meal_plan"
    ]

    prompt = f"""
    Extract grocery items
    from this meal plan.

    Return ONLY valid JSON.

    Format:
    {{
      "groceries": [
        {{
          "item": "Rice",
          "quantity": "2kg"
        }}
      ]
    }}

    Meal Plan:
    {meal_plan}
    """

    result = generate_json_response(
        prompt
    )

    return {
        "grocery_list": result
    }