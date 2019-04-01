var jwt = require('jsonwebtoken');
const config = require('config');
const jwt_config = config.JWT;

class Middware {
    checkToken(req, res, next) {
        let token = req.headers.token;

        if(token) {
            jwt.verify(req.headers.token, jwt_config.screet_key, (err, decoded) => {
                if (err) {
                    res.status(401);
                    res.json({
                        data: null,
                        message: err.name + ': ' + err.message,
                        key: null,
                        status: 401
                    });
                }

                req.pay_load = decoded.data;
                next();
            });
        } else {
            res.status(401);
            res.json({
                data: null,
                message: 'Token is not empty',
                key: null,
                status: 401
            })
        }
    }
}

module.exports = Middware;