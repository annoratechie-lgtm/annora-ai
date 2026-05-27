from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from api.routes.onboarding import router as onboarding_router
from api.routes.meals import router as meals_router

app = FastAPI()

# CORS CONFIGURATION
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ROUTES
app.include_router(onboarding_router)
app.include_router(meals_router)


@app.get("/")
def home():
    return {"message": "Backend running"}