from fastapi import APIRouter
from schemas.onboarding_schema import OnboardingSchema
from services.db_service import supabase

router = APIRouter()


@router.post("/onboarding")
def save_onboarding(data: OnboardingSchema):

    response = (
        supabase.table("onboarding_profiles")
        .insert(data.dict())
        .execute()
    )

    return {
        "message": "Onboarding saved",
        "data": response.data
    }