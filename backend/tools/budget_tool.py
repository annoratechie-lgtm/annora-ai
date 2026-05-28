PRICE_DB = {

    "rice": 60,
    "milk": 30,
    "eggs": 7,
    "bread": 40,
    "chicken": 220,
    "tomato": 25,
    "onion": 30,
    "oats": 120,
    "banana": 8,
    "apple": 20,
}


def estimate_budget(grocery_data):

    groceries = grocery_data.get(
        "groceries",
        [],
    )

    total = 0

    for item in groceries:

        name = (
            item.get("item", "")
            .lower()
            .strip()
        )

        quantity = item.get(
            "quantity",
            "1"
        )

        try:

            qty = int(
                ''.join(
                    filter(
                        str.isdigit,
                        quantity
                    )
                ) or 1
            )

        except:

            qty = 1

        price = PRICE_DB.get(
            name,
            50
        )

        total += price * qty

    return {
        "estimated_total": total
    }