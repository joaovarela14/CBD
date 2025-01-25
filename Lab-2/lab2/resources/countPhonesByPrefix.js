countPhonesByPrefix = function () {
    var result = db.phones.aggregate([
        {
            $group: {
                _id: "$components.prefix",
                count: { $sum: 1 }
            }
        },
        {
            $sort: { _id: 1 }
        }
    ]);

    result.forEach(function (doc) {
        print("Prefix: " + doc._id + ", Count: " + doc.count);
    });
}

// RESULTS

// test> countPhonesByPrefix()

// Prefix: 21, Count: 33326
// Prefix: 22, Count: 33403
// Prefix: 231, Count: 33286
// Prefix: 232, Count: 33738
// Prefix: 233, Count: 33071
// Prefix: 234, Count: 33176
