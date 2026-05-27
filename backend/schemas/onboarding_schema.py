from pydantic import BaseModel
from typing import List


class OnboardingSchema(BaseModel):
    user_id: str
    age: int
    gender: str
    diet_type: str
    allergies: List[str]
    budget: int
    family_size: int