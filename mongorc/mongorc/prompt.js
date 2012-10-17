var stringDate = function() {
    var now = new Date();
    return "[" + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds() + "] ";
};

prompt = function() {
    var cluster = db.adminCommand({isdbgrid : 1});
    if (cluster.ok == 1) {
        return stringDate() + "mongos> ";
    }

    var result = db.isMaster();
    if (result.ismaster) {
        return stringDate() + db + "> ";
    }
    return stringDate() + "(" + db + ")> ";
};
