class BaseController {
    constructor() {

    }

    responseData(data=null, message='', key=null, status=200) {
        return {
            data: data,
            message: message,
            key: key,
            status: status
        }
    }
}

module.exports = BaseController;