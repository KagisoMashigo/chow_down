const CONNECTION_TIMEOUT_TIME = Duration(milliseconds: 60000);
const RECEIVE_TIMEOUT_TIME = Duration(milliseconds: 20000);
const SEND_TIMEOUT_TIME = Duration(milliseconds: 15000);
const URL_REGEX =
    r'^(https?:\/\/)?((([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,})|localhost|((\d{1,3}\.){3}\d{1,3}))(:\d+)?(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?$';
