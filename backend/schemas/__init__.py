from pydantic import BaseModel
from typing import List


class DailyMeal(BaseModel):

    day: str

    breakfast: str

    lunch: str

    dinner: str


class MealPlan(BaseModel):

    meals: List[DailyMeal]


class GroceryItem(BaseModel):

    item: str

    quantity: str


class GroceryList(BaseModel):

    groceries: List[GroceryItem]