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

    changeInfo(email, body) {
        let sql = `CALL sp_nodejs_change_info_user(
            '${body.name}', 
            '${email.username}', 
            '${body.birthday}', 
            '${body.address}', 
            '${body.phone}')`;
        return db.update(sql);
    }

    changePass(email, body) {
        let sql = `CALL sp_nodejs_change_pass_user(
            '${body.old_pass}', 
            '${email.new_pass}')`;
        return db.update(sql);
    }
}

module.exports = User;