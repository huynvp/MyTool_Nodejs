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

    addApi(project_id, method, name, content, params, response) {
        var sql = `CALL sp_add_api(${project_id}, '${method}', '${name}', '${content}', '${params}', '${response}')`;
        return db.load(sql);
    }

    addProject(name) {
        var sql = `INSERT INTO project(user_id, project_name, project_status, created_at, updated_at) VALUES (1, '${name}', 1, Now(), Now())`;
        return db.insert(sql);
    }

    showOneApi(id) {
        var sql = `SELECT * FROM api WHERE api_id=${id}`;
        return db.load(sql);
    }

    editApi(api_id, method, name, content, params, response) {
        var sql = `CALL sp_edit_api(${api_id}, '${method}', '${name}', '${content}', '${params}', '${response}')`;
        return db.load(sql);
    }
    
    deleteApi(id) {
        var sql = `CALL sp_delete_api(${id})`;
        return db.load(sql);
    }
}

module.exports = Note;