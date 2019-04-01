var db = require('../function/mysql');

class User {
    checkLogin(username, password) {
        let sql = `CALL sp_nodejs_checklogin('${username}', '${password}')`;
        return db.load(sql);
    }

    showUser(username) {
        let sql = `CALL sp_nodejs_show_user('${username}');`;
        return db.load(sql);
    }
}

module.exports = User;