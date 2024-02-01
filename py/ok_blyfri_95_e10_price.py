# Vejledende standerpriser på OK blyfri 95 E10 tankstationer i DDK
#
import requests
from bs4 import BeautifulSoup

url = "https://www.ok.dk/offentlig/produkter/braendstof/priser/vejledende-standerpriser"

# Make a GET request to the website
response = requests.get(url)

# Check if the request was successful (status code 200)
if response.status_code == 200:
    # Parse the HTML content
    soup = BeautifulSoup(response.content, "html.parser")

    # Extract the relevant data using CSS selectors
    fuel_price_element = soup.select_one(".flex-table__moreinfo-row > :nth-child(2)")

    if fuel_price_element:
        # Extract the text and perform necessary cleanup
        fuel_price = fuel_price_element.get_text(strip=True).replace(",", ".")
        
        # Remove the "kr." part
        fuel_price = fuel_price.replace("kr.", "").strip()

        # Print or use the fuel price as needed
        print(fuel_price)
    else:
        print("Fuel price element not found.")
else:
    print("Failed to retrieve the web page. Status code:", response.status_code)

