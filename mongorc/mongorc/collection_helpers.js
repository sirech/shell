// show collections
var sc = function() {
    var out = db.getCollectionNames();
    out.forEach(
        function(value) {
            print(value);
        });
};

// compacts all collections
var compactAll = function() {
    var out = db.getCollectionNames();
    out.forEach(
        function(value) {
            print('Compact '+value);
            col = db.getCollection(value);
            col.runCommand('compact');
        });
};
