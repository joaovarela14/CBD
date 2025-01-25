async function findSequence(sequence) {
    const phonesArray = await db.phones.find({}).toArray(); // Ensure the query completes

    const result = [];

    phonesArray.forEach((phone) => {
        const number = phone.display.split("-")[1];
        if (number.includes(sequence)) {
            result.push(phone);
        }
    });

    //print numbers in result
    result.forEach((phone) => {
        print(phone.display);
    });
}

// RESULT

// test> findSequence("12353")
// +351-210012353
// +351-234112353
// +351-220123530
// +351-232123531
// +351-233123532
// +351-234123533
// +351-233123534
// +351-233123535
// +351-232123536
// +351-232123537
// +351-231123538
// +351-210123539
