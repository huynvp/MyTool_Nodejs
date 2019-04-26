var db = require('../function/mysql');

class Note {
    constructor() {
        // console.log('Class note constructor');
    }

    showAllNote() {
        return db.load(`SELECT * FROM my_note, level WHERE my_note.level_id = level.level_id ORDER BY orders, created_at DESC`);
    }

    showOnceNote(id_note) {
        return db.load(`SELECT * FROM my_note WHERE note_id = ${id_note}`);
    }

    addNote(note) {
        var sql = `INSERT INTO my_note (title, content, date, user, level_id, orders, status, created_at, updated_at) 
            VALUE ('${note.title}', '${note.content}', '${note.date}', 1, ${note.level}, ${note.orders}, 0, NOW(), NOW())`;
        return db.insert(sql);
    }

    editNote(note) {
        var sql = `UPDATE my_note 
                SET title='${note.title}', content='${note.content}', level_id='${note.level}', 
                date='${note.date}', orders=${note.orders},updated_at=NOW()
                WHERE note_id=${note.id}`;
        return db.update(sql);
    }

    deleteNote(note_id) {
        var sql = `DELETE FROM my_note WHERE note_id=${note_id}`;
        return db.delete(sql);
    }

    showLevel() {
        var sql = `SELECT * FROM level`;
        return db.load(sql);
    }
}

module.exports = Note;