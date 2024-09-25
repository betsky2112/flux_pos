const midtransClient = require('midtrans-client');

// Create Snap API instance
let snap = new midtransClient.Snap({
    isProduction: false,
    serverKey: 'Mid-server-lSBha-JIGL06PR7cOPsnwH2X',
});

// Handle transaction request
app.post('/createTransaction', (req, res) => {
    let parameter = {
    transaction_details: {
        order_id: `order-id-${new Date().getTime()}`,
        gross_amount: req.body.amount,
    },
    credit_card: {
        secure: true,
    },
    customer_details: {
        first_name: req.body.firstName,
        last_name: req.body.lastName,
        email: req.body.email,
        phone: req.body.phone,
    },
    };

    snap.createTransaction(parameter)
    .then((transaction) => {
        res.status(200).send(transaction);
    })
    .catch((error) => {
        res.status(500).send(error);
    });
});
