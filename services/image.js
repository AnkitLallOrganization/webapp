const uuid = require('uuid');
const fs = require('fs');
const path = require("path");
const AWS = require('aws-sdk');
const uploadFile = require("../middleware/upload");

const ID = 'AKIAZ47FLKF6IMH2LM62';
const SECRET = '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';

// The name of the bucket that you have created
const BUCKET_NAME = process.env.BUCKETNAME;

const s3 = new AWS.S3({
    accessKeyId: ID,
    secretAccessKey: SECRET
});

const upload = async (req,res) => {
    try {
        await uploadFile(req, res);
    
        if (req.file == undefined) {
          return res.status(400).send({ message: "Please upload a file!" });
        }

        let fileName=req.file.filename;
        // Read content from the file
        const fileContent = fs.readFileSync(req.file.destination + '/' + fileName);
        const key = uuid.v4() + '/' + req.file.originalname;
        // Setting up S3 upload parameters
        const uploadParams = {
            Bucket: BUCKET_NAME,
            Key: key, // File name you want to save as in S3
            Body: fileContent
        };
    
        // Uploading files to the bucket
        let data = await s3.upload(uploadParams).promise();

        fs.readdir('assets', (err, files) => {
            if (err) throw err;
          
            for (const file of files) {
              fs.unlink(path.join('assets', file), (err) => {
                if (err) throw err;
              });
            }
        });

        var metaParams = {                
            Bucket: BUCKET_NAME,                
            Key: key               
        };                
        let metadata = await s3.headObject(metaParams).promise();
    
        res.status(200).send({
          message: "Uploaded the file successfully: " + JSON.stringify(metadata),
        });
    } catch (err) {
        res.status(500).send({
          message: `Could not upload the file: ${req.file.originalname}. ${err}`,
        });
    }
};

module.exports = {
    upload
}