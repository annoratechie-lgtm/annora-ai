from fastapi import APIRouter
from services.db_service import supabase
from services.llm_service import generate_meal_plan

router = APIRouter()


@router.post("/generate-meal-plan/{user_id}")
def create_meal_plan(user_id: str):

    onboarding_response = (
        supabase.table("onboarding_profiles")
        .select("*")
        .eq("user_id", user_id)
        .execute()
    )

    if not onboarding_response.data:
        return {"error": "User onboarding not found"}

    profile_data = onboarding_response.data[0]

    meal_plan = generate_meal_plan(profile_data)

    save_response = (
        supabase.table("meal_plans")
        .insert({
            "user_id": user_id,
            "meal_data": meal_plan
        })
        .execute()
    )

    return {
        "message": "Meal plan generated",
        "meal_plan": meal_plan,
        "saved_data": save_response.data
    }