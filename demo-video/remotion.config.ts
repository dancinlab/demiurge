// Remotion config — 1920x1080 @ 30fps, h.264 high quality for YouTube.
import { Config } from "@remotion/cli/config";

Config.setVideoImageFormat("jpeg");
Config.setOverwriteOutput(true);
Config.setPixelFormat("yuv420p");
Config.setCodec("h264");
Config.setCrf(18); // visually lossless
Config.setConcurrency(null); // auto-detect cores
