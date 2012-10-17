var replLag = function() {

    var optimeDate = function() {
        var members = rs.status().members;

        if(members) {
            for(var i = 0; i < members.length; i++) {
                var member = members[i];
                if(member['stateStr'] == 'PRIMARY') {
                    return member['optimeDate'];
                }
            }
        }

        return 0;
    };

    var myOptimeDate = function() {
        var members = rs.status().members;

        if(members) {
            for(var i = 0; i < members.length; i++) {
                var member = members[i];
                if(member['self']) {
                    return member['optimeDate'];
                }
            }
        }

        return 0;
    };

    return function() {
        return (optimeDate() - myOptimeDate()) / 1000;
    };
}();

var summary = function() {
    var status = db.serverStatus();
    var uptime = status.uptime;
    var setName = status.repl ? status.repl.setName : "";
    var primary = status.repl ? status.repl.primary : "";
    var replag = replLag();
    var curConnections = status.connections.current;
    var resMem = status.mem.resident;
    var userAsserts = status.asserts.user;
    var warningAsserts = status.asserts.warning;
    var totalQueues = status.globalLock.currentQueue.total;
    var lockRatio = status.globalLock.ratio;
    var readQueues = status.globalLock.currentQueue.readers;

    print('\tSystem information as of ' + db.serverStatus().localTime);
    print('\n\t** Replication **');
    print("\tPrimary: " + primary + "\tReplag: " + replag + ' (s)');

    print('\n\t** Uptime **');
    var uptimeHours = Math.floor(uptime / (60 * 60));
    var uptimeMinutes = Math.floor((uptime - (uptimeHours * 60 * 60)) / 60);
    print("\tuptime: " + uptime + ' (s)' + '\thuman: ' + uptimeHours + 'h' + ' and ' + uptimeMinutes + 'm');

    print('\n\t** Connections **');
    print("\tCurrent: " + curConnections + "\tQueued: " + totalQueues + "\t% read:" + readQueues / (totalQueues + 1) + "\tLock Ratio: " + lockRatio);

    print('\n\t** Asserts **');
    print("\tUser: " + userAsserts + "\tWarning: " + warningAsserts);
}();
