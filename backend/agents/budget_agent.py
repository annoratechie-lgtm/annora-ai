from mcp.tool_registry import (
    run_tool,
)


def budget_agent(state):

    grocery_list = state[
        "grocery_list"
    ]

    estimated_budget = run_tool(
        "budget_estimator",
        grocery_list,
    )

    return {
        "estimated_budget":
            estimated_budget
    }