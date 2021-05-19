
// External Modules
// MongoDB connection
var mongoose = require( 'mongoose' ); 

var dbURI = "mongodb://root:rootpassword@localhost:27017/clowndb?authSource=admin";
mongoose.connect(dbURI);

// CONNECTION EVENTS
// When successfully connected
mongoose.connection.on('connected', function () {  
}); 

// If the connection throws an error
mongoose.connection.on('error',function (err) {  
}); 

// When the connection is disconnected
mongoose.connection.on('disconnected', function () {  
});

// If the Node process ends, close the Mongoose connection 
process.on('SIGINT', function() {  
  mongoose.connection.close(function () { 
    console.log('Mongoose default connection disconnected through app termination'); 
    process.exit(0); 
  }); 
}); 


module.exports.db = mongoose;