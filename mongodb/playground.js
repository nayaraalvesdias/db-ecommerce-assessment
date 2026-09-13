//use shipping_collection.json to insert shipping data
db.createCollection("shippings")

// search by status and limit
db.getCollection("shippings").find(
    {
        status: {
            $in: ["OUT_FOR_DELIVERY", "PACKED", "SHIPPED"]
        }
    },
    {
        "recipient.name": 1,
        status: 1,
        _id: 0
    }
).limit(10);

// find by object inside document
const doc = db.getCollection("shippings").findOne({
    "recipient.address.zipCode": "82011086"
});

print(doc.recipient.name)

// update recipient name found previous
shippings.updateOne({ _id: doc._id },
    {
        $set: {
            "recipient.name": "New Name"
        }
    }
);

// check last update
db.getCollection("shippings").findOne({ "recipient.address.zipCode": "82011086" }, { "recipient.name": 1 });


//creating new collection
db.createCollection("status_details")

//inserting status description
db.status_details.insertMany([
    {
        _id: 1,
        status: "PLACED",
        description: "We've received your order"
    },
    {
        _id: 2,
        status: "PACKED",
        description: "Your order was prepared"
    },
    {
        _id: 3,
        status: "SHIPPED",
        description: "Your order has been shipped"
    },
    {
        _id: 4,
        status: "TRANSIT",
        description: "Your order is on the way"
    },
    {
        _id: 5,
        status: "OUT_FOR_DELIVERY",
        description: "Your order is arriving soon"
    },
    {
        _id: 6,
        status: "DELIVERED",
        description: "Your order has arrived"
    }
])


//  count by status
db.shippings.aggregate([
    {
        $group: {
            _id: "$status",
            count: { $sum: 1 }
        }
    },
    {
        $sort: { count: -1 }
    }
])

// count by status and join with status details
db.shippings.aggregate([
    {
        $group: {
            _id: "$status",
            count: { $sum: 1 },
        }
    },
    {
        $lookup: {
            from: "status_details",
            localField: "_id",
            foreignField: "status",
            as: "shipping_status_description",
        },
    },
    {
        $project: {
            _id: 0,
            status: "$_id",
            count: 1, //include count as it already exists
            description: {
                $arrayElemAt: ["$shipping_status_description.description", 0]
            }
        }
    },
    {
        $sort: {
            "count": -1
        }
    }
])