
# react-native-get-thumbnail

## Getting started

`$ npm install react-native-get-thumbnail --save`

### Mostly automatic installation

`$ react-native link react-native-get-thumbnail`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-get-thumbnail` and add `RNGetThumbnail.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNGetThumbnail.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNGetThumbnailPackage;` to the imports at the top of the file
  - Add `new RNGetThumbnailPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-get-thumbnail'
  	project(':react-native-get-thumbnail').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-get-thumbnail/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-get-thumbnail')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNGetThumbnail.sln` in `node_modules/react-native-get-thumbnail/windows/RNGetThumbnail.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Get.Thumbnail.RNGetThumbnail;` to the usings at the top of the file
  - Add `new RNGetThumbnailPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNGetThumbnail from 'react-native-get-thumbnail';

// TODO: What to do with the module?
RNGetThumbnail;
```



## Example code

```javascript

import React, {useState} from 'react';
import {
  SafeAreaView,
  Text,
  TouchableOpacity,
  Image,
} from 'react-native';

import RNGetThumbnail from 'react-native-get-thumbnail';

const App: () => React$Node = () => {
  const [uri, setUri] = useState('');

  const generateThumbnail = async () => {
    try {
      const {uri} = await RNGetThumbnail.getThumbnail(
        'http://d23dyxeqlo5psv.cloudfront.net/big_buck_bunny.mp4',
        {
          time: 5000,
        },
      );
      console.log(uri);
      setUri(uri);
    } catch (e) {
      console.warn(e);
    }
  };
  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView>
         <TouchableOpacity onPress={generateThumbnail}>
              <Text>GET IMAGE</Text>
            </TouchableOpacity>
            <Image
              source={{uri: uri}}
              style={{height: 500, flex: 1}}
              resizeMode={'contain'}></Image>
      </SafeAreaView>
    </>
  );
};

export default App;
```