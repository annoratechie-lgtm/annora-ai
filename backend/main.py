from fastapi import FastAPI

from api.routes.onboarding import router as onboarding_router
from api.routes.meals import router as meals_router

app = FastAPI()

app.include_router(onboarding_router)
app.include_router(meals_router)


@app.get("/")
def home():
    return {"message": "Backend running"}