from flask import Flask, jsonify

app = Flask(__name__)

# Combined data (from your request)
data = {
    "people": [
        {
            "name": "John Doe",
            "age": 35,
            "employer": {
                "company_name": "Tech Solutions Inc.",
                "position": "Software Engineer",
                "department": "Research & Development",
                "work_email": "john.doe@techsolutions.com"
            },
            "address": {
                "street": "123 Main Street",
                "city": "New York",
                "state": "NY",
                "zip_code": "10001",
                "country": "USA"
            }
        },
        {
            "name": "John Doe",
            "age": 35,
            "employer": {
                "company_name": "Tech Solutions Inc.",
                "position": "Software Engineer",
                "department": "Research & Development",
                "work_email": "john.doe@techsolutions.com"
            },
            "address": {
                "street": "456 Corporate Plaza",
                "city": "San Francisco",
                "state": "CA",
                "zip_code": "94105",
                "country": "USA"
            }
        },
        {
            "name": "John Doe",
            "age": 35,
            "employer": {
                "company_name": "Global Innovations",
                "position": "Senior Developer",
                "department": "Software Engineering",
                "work_email": "john.doe@globalinnovations.com"
            },
            "address": {
                "street": "789 Business Park",
                "city": "Austin",
                "state": "TX",
                "zip_code": "73301",
                "country": "USA"
            }
        },
        {
            "name": "Jane Smith",
            "age": 28,
            "employer": {
                "company_name": "Creative Studios",
                "position": "Graphic Designer",
                "department": "Design",
                "work_email": "jane.smith@creativestudios.com"
            },
            "address": {
                "street": "456 Oak Avenue",
                "city": "Los Angeles",
                "state": "CA",
                "zip_code": "90001",
                "country": "USA"
            }
        },
        {
            "name": "Jane Smith",
            "age": 28,
            "employer": {
                "company_name": "Creative Studios",
                "position": "Graphic Designer",
                "department": "Design",
                "work_email": "jane.smith@creativestudios.com"
            },
            "address": {
                "street": "101 Design Square",
                "city": "San Francisco",
                "state": "CA",
                "zip_code": "94110",
                "country": "USA"
            }
        },
        {
            "name": "Jane Smith",
            "age": 28,
            "employer": {
                "company_name": "Artistic Ventures",
                "position": "Art Director",
                "department": "Creative",
                "work_email": "jane.smith@artisticventures.com"
            },
            "address": {
                "street": "202 Innovation Drive",
                "city": "Miami",
                "state": "FL",
                "zip_code": "33101",
                "country": "USA"
            }
        }
    ]
}

@app.route('/api/people', methods=['GET'])
def get_people():
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True)
