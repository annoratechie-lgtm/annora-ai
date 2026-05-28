from tools.budget_tool import (
    estimate_budget,
)

TOOLS = {

    "budget_estimator": {

        "function":
            estimate_budget,

        "description":
            "Estimate grocery budget",
    }
}


def run_tool(
    tool_name,
    payload,
):

    tool_data = TOOLS.get(
        tool_name
    )

    if not tool_data:

        raise Exception(
            f"Tool not found: {tool_name}"
        )

    tool_function = tool_data[
        "function"
    ]

    return tool_function(payload)


def list_tools():

    return {
        name: data["description"]
        for name, data
        in TOOLS.items()
    }