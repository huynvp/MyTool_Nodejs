var db = require('../function/mysql');

class Note {
    constructor() {
    }

    showProject() {
        var sql = `CALL sp_show_all_project()`;
        return db.load(sql);
    }

    showDetailProject(id) {
        var sql = `CALL sp_show_detail_project(${id})`;
        return db.load(sql);
    }
    
}

module.exports = Note;