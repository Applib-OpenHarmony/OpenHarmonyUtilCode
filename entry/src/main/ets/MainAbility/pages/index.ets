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

import router from '@system.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Row() {
        Column() {
          Button('Clean Utils')
            .width('70%')
            .height(50)
            .onClick(() => router.push({ uri: "pages/CleanUtilsSample" }))
        }.width('100%')
      }.height('30%')

      Row() {
        Column() {
          Button('Array Utils')
            .width('70%')
            .height(50)
            .onClick(() => router.push({ uri: "pages/ArrayUtilsSample" }))
        }.width('100%')
      }.height('30%')

      Row() {
        Column() {
          Button('Location Utils')
            .width('70%')
            .height(50)
            .onClick(() => router.push({ uri: "pages/LocationUtilsSample" }))
        }.width('100%')
      }.height('50%')
    }.width('90%').height('100%')
  }
}