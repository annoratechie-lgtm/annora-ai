from fastapi import APIRouter, HTTPException
from services.db_service import supabase
from services.llm_service import generate_meal_plan
from agents.graph import meal_graph

router = APIRouter()


@router.post("/generate-meal-plan/{user_id}")
def create_meal_plan(user_id: str):

    onboarding_response = (
        supabase.table("onboarding_profiles")
        .select("*")
        .eq("user_id", user_id)
        .execute()
    )

    onboarding_data = onboarding_response.data

    if not onboarding_data:
        raise HTTPException(
            status_code=404,
            detail="User onboarding not found",
        )

    user_profile = onboarding_data[0]

    try:

        result = meal_graph.invoke({
            "user_profile": user_profile
        })

        meal_plan = result[
            "validated_meal_plan"
        ]

        grocery_list = result[
            "grocery_list"
        ]
        estimated_budget = result[
    "estimated_budget"
]

    except Exception as exc:

        raise HTTPException(
            status_code=502,
            detail=f"Meal plan generation failed: {exc}",
        )

    # SAVE TO HISTORY
    supabase.table("meal_history").insert({
        "user_id": user_id,
        "meal_plan": meal_plan
    }).execute()

    return {
    "meal_plan": meal_plan,
    "grocery_list": grocery_list,
    "estimated_budget": estimated_budget
}


@router.get("/meal-history/{user_id}")
def get_meal_history(user_id: str):

    response = (
        supabase.table("meal_history")
        .select("*")
        .eq("user_id", user_id)
        .order("created_at", desc=True)
        .execute()
    )

    return response.data