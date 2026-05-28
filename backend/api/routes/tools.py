from fastapi import APIRouter

from mcp.tool_registry import (
    list_tools,
)

router = APIRouter()


@router.get("/tools")
def get_tools():

    return list_tools()