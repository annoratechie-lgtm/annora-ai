from services.llm_service import (
    generate_json_response,
)


def nutrition_agent(state):

    meal_plan = state["meal_plan"]

    prompt = f"""
    Improve and validate this meal plan.

    Return ONLY valid JSON
    in SAME structure.

    Meal Plan:
    {meal_plan}
    """

    result = generate_json_response(
        prompt
    )

    return {
        "validated_meal_plan":
            result
    }