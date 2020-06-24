import React from "react";
import PropTypes from "prop-types";
import { requireNativeComponent, NativeModules } from "react-native";

const { RNGetThumbnail } = NativeModules;

type ThumbnailOptions = {
  time?: number,
  base64?: boolean,
};

class VideoThumbnail {
  static async getThumbnail(source: string, options?: ThumbnailOptions) {
    if (!options) {
      options = {};
    }
    if (!options.time) {
      options.time = 1;
    }
    if (!options.base64) {
      options.base64 = false;
    }
    return await RNGetThumbnail.getThumbnail(source, options);
  }
}

// const VideoThumbnail = requireNativeComponent(
//   "RNGetThumbnail",
//   GetThumbnail,
//   {}
// );

export default VideoThumbnail;
