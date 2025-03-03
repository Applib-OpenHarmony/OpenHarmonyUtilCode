/*
* Copyright (C) 2022 Application library engineering group.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import ability_featureAbility from '@ohos.ability.featureAbility';
import fileio from '@ohos.fileio';
import file from '@system.file';
import dataStorage from '@ohos.data.storage';
import dataRdb from '@ohos.data.rdb';
import bundleManager from "@ohos.bundle";

export class CleanUtils {
  constructor() {

  }

  async cleanInternalCache() {
    var context = ability_featureAbility.getContext();
    var path;
    context.getCacheDir((error, data) => {
      if (error) {
        console.error('Failed to obtain Cache Directory. Cause: ' + error.message);
        return error.message;
      }
      console.info('Cache directory Obtained. Data: ' + JSON.stringify(data))
      path = data;
      fileio.rmdirSync(data);
    })
    return path;
  }

  async cleanInternalFiles() {
    var path;
    var context = ability_featureAbility.getContext();
    context.getFilesDir((error, data) => {
      if (error) {
        console.error('Failed to obtain the file directory. Cause: ' + error.message + 'Code: ' + error.code);
        return error.message;
      }
      console.info('File directory Obtained. Data: ' + JSON.stringify(data))
      path = data;
      console.log(path);
      fileio.rmdirSync(path);
    })
    return path;
  }

  async cleanInternalSp() {
    var context = ability_featureAbility.getContext();
    var path;

    context.getFilesDir((error, data) => {
      if (error) {
        console.error('Failed to obtain File Directory. Cause: ' + JSON.stringify(error));
        return JSON.stringify(error);
      }
      console.info('File directory Obtained. Data: ' + JSON.stringify(data))
      console.info(data)
      path = data + '/sharedPreference';
      dataStorage.deleteStorage(path, function (err) {
        if (err) {
          console.info("Shared Preference Delete Failed" + err)
          return
        }
        console.info("Shared Preference Delete Success")
      })
    })
    return path;
  }

  async cleanInternalDbByName(dbName: string) {
    var message;
    if (dbName == null) {
      console.error("Database Delete Fail => No Database name entered");
      message = "Database Delete Fail => No Database name entered";
    }
    else {
      dataRdb.deleteRdbStore(this, dbName, function (err, rdbStore) {
        if (err) {
          console.log("Error in Deleting Database => " + err);
          message = "Error in Deleting Database => " + err;
        }
        console.info('Database Delete Success: =>' + dbName);
        message = "Database Delete Success => " + dbName;
      })
    }
    return message;
  }

  async cleanInternalDbs() {
    var dbPath;
    let bundleName = "com.example.cleanutilsets_1";
    let bundleFlags = 0;
    bundleManager.getApplicationInfo(bundleName, bundleFlags, (err, data) => {
      if (err) {
        console.error('Application Information fetch failed. Cause: ' + JSON.stringify(err));
        return;
      }
      console.info('Application Information fetched successfully. Data:' + JSON.stringify(data));
      dbPath = data.entryDir + '/database';
      console.log('DB Directory: ' + dbPath);
      fileio.rmdirSync(dbPath);
    })
    return dbPath;
  }

  async cleanCustomDir(dirPath: string) {
    if (dirPath == null) {
      console.error("No Directory Path Entered");
      return "Directory Clean Fail => No Directory Path Entered";
    }
    else {
      var stringArray = dirPath.split('/');
      if (stringArray.length > 0) {
        fileio.rmdirSync(dirPath);
        console.log('Clean Directory Success');
        return "Directory Clean Success => " + dirPath;
      }
      else {
        console.log('Clean Directory Failed => Directory Path not valid');
        return "Clean Directory Failed => Directory Path not valid";
      }
    }
  }
}