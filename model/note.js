var db = require('../function/mysql');

exports.showAllNote = () => {
    return db.load(`SELECT * FROM my_note`);
}

exports.addNote = (note) => {
    var sql = `INSERT INTO my_note (title, content, date, status, created_at, updated_at) 
            VALUE ('${note.title}', '${note.content}', '${note.date}', 0, NOW(), NOW())`;
    return db.insert(sql);
}