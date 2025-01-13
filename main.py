from fastapi import FastAPI, HTTPException
import google.generativeai as genai

# Configure Gemini API
genai.configure(api_key="SECRET")  
model = genai.GenerativeModel("gemini-1.5-flash")

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Gemini API Backend is running!"}

@app.get("/generate-meal-plan/")
def generate_meal_plan(age: int, gender: str, diet_preference: str, allowed_food: str):
    try:
        prompt = f"Generate a 7-day healthy meal plan for a {age}-year-old {gender} who prefers {diet_preference} and eats {allowed_food}. List ONLY the name of the menu. we dont care about anything else. list it in this format -  1. MENU NAME\n2.  MENU NAME\n3. MENU NAME\n4.  MENU NAME\n5. MENU NAME\n6. MENU NAME\n7.  MENU NAME\n" 
        response = model.generate_content(prompt)
        return {"meal_plan": response.text}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/search-food/")
def search_food(query: str):
    try:
        prompt = f"Provide healthy for {query}. List only the name of the menu of atleast 5 items."
        response = model.generate_content(prompt)
        return {"recipes": response.text}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
