var db = require('../function/mysql');

exports.showAllNote = () => {
    return db.load(`SELECT * FROM my_note`);
}

exports.showOnceNote = (id_note) => {
    return db.load(`SELECT * FROM my_note WHERE note_id = ${id_note}`);
}

exports.addNote = (note) => {
    var sql = `INSERT INTO my_note (title, content, date, user, status, created_at, updated_at) 
            VALUE ('${note.title}', '${note.content}', '${note.date}', 1, 0, NOW(), NOW())`;
    return db.insert(sql);
}

exports.editNote = (note) => {
    var sql = `UPDATE my_note SET title='${note.title}', content='${note.content}', date='${note.date}',updated_at=NOW() WHERE note_id=${note.id}`;
    return db.update(sql);
}

exports.deleteNote = (note_id) => {
    var sql = `DELETE FROM my_note WHERE note_id=${note_id}`;
    return db.delete(sql);
}