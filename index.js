// @flow

import {
  DeviceEventEmitter,
  NativeEventEmitter,
  NativeModules,
  Platform,
} from 'react-native'

const { RNGoogleCast: GoogleCast } = NativeModules

import CastButton from './CastButton'
export { CastButton }

export default {
  getCastDevice() {
    return GoogleCast.getCastDevice()
  },
  getCastState() {
    return GoogleCast.getCastState().then(
      state =>
        ['NoDevicesAvailable', 'NotConnected', 'Connecting', 'Connected'][
          state
        ],
    )
  },
  castMedia(params) {
    return GoogleCast.castMedia(params)
  },
  /**
   * Ends the current session.
   *
   * This is an asynchronous operation.
   *
   * Resolves if the operation has been started successfully, rejects if there is no session currently established or if the operation could not be started.
   *
   * @param {Boolean} stopCasting Whether casting of content on the receiver should be stopped when the session is ended.
   * @returns {Promise}
   */
  endSession(stopCasting = false) {
    return GoogleCast.endSession(stopCasting)
  },
  /**
   * Begins (or resumes) playback of the current media item.
   */
  play: GoogleCast.play,
  /**
   * Pauses playback of the current media item.
   */
  pause: GoogleCast.pause,
  /**
   * Stops playback of the current media item.
   */
  stop: GoogleCast.stop,
  /**
   * Seeks to a new position within the current media item.
   *
   * @param {number} playPosition
   */
  seek(playPosition) {
    return GoogleCast.seek(playPosition)
  },
  launchExpandedControls: GoogleCast.launchExpandedControls,
  /**
   * Displays the Expanded Controls screen programmatically. Users can also open it by clicking on Mini Controls.
   *
   * @returns `true` if the Expanded Controls were shown, `false` if it was not shown.
   */
  showExpandedControls() {
    return GoogleCast.showExpandedControls()
  },
  /**
   * If it has not been shown before, presents a fullscreen modal view controller that calls attention to the Cast button and displays some brief instructional text about its use.
   *
   * By default, the overlay is only displayed once. To change this, pass `once: false` in the options.
   *
   * @returns Promise that becomes `true` if the view controller was shown, `false` if it was not shown because it had already been shown before, or if the Cast Button was not found.
   */
  showIntroductoryOverlay(options){
    return GoogleCast.showIntroductoryOverlay({ once: true, ...options })
  },
  setVolume(volume) {
    return GoogleCast.setVolume(volume)
  },
  setDeviceMuted(muted) {
    return GoogleCast.setDeviceMuted(muted)
  },
  initChannel(namespace) {
    return GoogleCast.initChannel(namespace)
  },
  sendMessage(namespace, message) {
    return GoogleCast.sendMessage(message, namespace)
  },
  showCastPicker(){
    GoogleCast.showCastPicker()
  },

  /**
   * Get available routes.
   *
   * @returns map of route ids and names.
   */
  getRoutes() {
    return GoogleCast.getRoutes()
  },

  /**
   * Select route.
   *
   * @returns success.
   */
  selectRoute(id) {
    return GoogleCast.selectRoute(id)
  },
  /**
   * Get actual playing stream metadata.
   *
   * @returns success.
   */
  getMediaInfo() {
    return GoogleCast.getMediaInfo()
  },
    /**
   * Get actual remote player state.
   *
   * @returns success.
   */
  getMediaStatus() {
    return GoogleCast.getMediaStatus()
  },

  /**
   * Get actual volume.
   *
   * @returns success.
   */
  getVolume() {
    return GoogleCast.getVolume()
  },
  /**
   * Is device muted.
   *
   * @returns muted.
   */
  isMuted() {
    return GoogleCast.isMuted()
  },

  /**
   * Disconnect.
   *
   * @returns success.
   */
  unselectRoute() {
    return GoogleCast.unselectRoute()
  },
  /**
   * Skip the x miliseconds.
   *
   * @param {number} interval
   */
  skip(interval) {
    return GoogleCast.skip(interval)
  },

  /**
   * Enable/disable subtitles, optionally selecting a preferred subtitle language.
   *
   * @param {boolean} enabled
   * @param {boolean} languageCode
   */
  toggleSubtitles(enabled, languageCode) {
    return GoogleCast.toggleSubtitles(enabled, languageCode)
  },

  // TODO use the same native event interface instead of hacking it here
  EventEmitter:
    Platform.OS === 'ios'
      ? new NativeEventEmitter(GoogleCast)
      : DeviceEventEmitter,

  SESSION_STARTING: GoogleCast.SESSION_STARTING,
  SESSION_STARTED: GoogleCast.SESSION_STARTED,
  SESSION_START_FAILED: GoogleCast.SESSION_START_FAILED,
  SESSION_SUSPENDED: GoogleCast.SESSION_SUSPENDED,
  SESSION_RESUMING: GoogleCast.SESSION_RESUMING,
  SESSION_RESUMED: GoogleCast.SESSION_RESUMED,
  SESSION_ENDING: GoogleCast.SESSION_ENDING,
  SESSION_ENDED: GoogleCast.SESSION_ENDED,

  MEDIA_STATUS_UPDATED: GoogleCast.MEDIA_STATUS_UPDATED,
  MEDIA_PLAYBACK_STARTED: GoogleCast.MEDIA_PLAYBACK_STARTED,
  MEDIA_PLAYBACK_ENDED: GoogleCast.MEDIA_PLAYBACK_ENDED,
  MEDIA_PROGRESS_UPDATED: GoogleCast.MEDIA_PROGRESS_UPDATED,
  MEDIA_METADATA_CHANGED: GoogleCast.MEDIA_METADATA_CHANGED,

  CHANNEL_CONNECTED: GoogleCast.CHANNEL_CONNECTED,
  CHANNEL_DISCONNECTED: GoogleCast.CHANNEL_DISCONNECTED,
  CHANNEL_MESSAGE_RECEIVED: GoogleCast.CHANNEL_MESSAGE_RECEIVED,
}
