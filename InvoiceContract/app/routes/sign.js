const express = require('express');
const router = express.Router();
const multer = require('multer');
// const upload = multer();

const storage = multer.diskStorage({
    destination (req, file, cb) {
        cb(null, 'images');
    },
    filename (req, file, cb) {
        cb(null, file.originalname);
    }
})
const upload = multer({storage});
const signatureController = require('../controller/signature/signatureController')

router.post('/sign', upload.single('image'), signatureController.signTransaction);
router.post('/verify', signatureController.verifyTransaction);


module.exports = router;

