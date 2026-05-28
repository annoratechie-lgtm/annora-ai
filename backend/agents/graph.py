from typing import TypedDict

from langgraph.graph import (
    StateGraph,
    END,
)

from agents.planner_agent import (
    planner_agent,
)

from agents.nutrition_agent import (
    nutrition_agent,
)

from agents.grocery_agent import (
    grocery_agent,
)

from agents.budget_agent import (
    budget_agent,
)


class MealState(TypedDict):

    user_profile: dict

    meal_plan: dict

    validated_meal_plan: dict

    grocery_list: dict

    estimated_budget: dict


graph = StateGraph(MealState)

graph.add_node(
    "planner",
    planner_agent,
)

graph.add_node(
    "nutrition",
    nutrition_agent,
)

graph.add_node(
    "grocery",
    grocery_agent,
)

graph.add_node(
    "budget",
    budget_agent,
)

graph.set_entry_point(
    "planner"
)

graph.add_edge(
    "planner",
    "nutrition",
)

graph.add_edge(
    "nutrition",
    "grocery",
)

graph.add_edge(
    "grocery",
    "budget",
)

graph.add_edge(
    "budget",
    END,
)

meal_graph = graph.compile()