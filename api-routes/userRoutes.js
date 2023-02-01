var express = require('express');
var router = express.Router();

var user = require('../services/user');
var helper = require('../config/helper');

router.post('/', user.createNewUser);

router.get('/:id', helper.bAuthCheck, user.getUser);

router.put('/:id', helper.bAuthCheck, user.updateUser);

module.exports = router;