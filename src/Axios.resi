type config

type response<'data> = {
    data: 'data,
    status: int,
    statusText: string,
    headers: Js.Dict.t<string>,
    config: config,
    request: Js.Dict.t<string>
}

type error<'responseData,'requestData> = {
  response: option<response<'responseData>>,
  request: option<'requestData>,
  message: string
}

type adapter<'a> = config => promise<response<'a>>
type requestTransformer<'data, 'a, 'transformedData> = ('data, Js.t<'a>) => 'transformedData
type responseTransformer<'data, 'transformedData> = 'data => 'transformedData
type paramsSerializer<'params, 'serializedParams> = 'params => 'serializedParams

type auth = {
  username: string,
  password: string,
}

type proxy = {
    protocol: string,
    host: string, 
    port: int, 
    auth: auth
}

let makeConfig: (
  ~url: string,
  ~method: string=?,
  ~baseURL: string=?,
  ~transformRequest: array<requestTransformer<'data, Js.t<'a>, 'tranformedData>>=?,
  ~transformResponse: array<responseTransformer<'data, 'tranformedData>>=?,
  ~headers: Js.Dict.t<string>=?,
  ~params: Js.t<'params>=?,
  ~paramsSerializer: paramsSerializer<'params, 'serializedParams>=?,
  ~data: Js.t<'data>=?,
  ~timeout: int=?,
  ~withCredentials: bool=?,
  ~adapter: adapter<'a>=?,
  ~auth: auth=?,
  ~responseType: string=?,
  ~xsrfCookieName: string=?,
  ~xsrfHeaderName: string=?,
  ~onUploadProgress: 'uploadProgress => unit=?,
  ~onDownloadProgress: 'downloadProgress => unit=?,
  ~maxContentLength: int=?,
  ~validateStatus: int => bool=?,
  ~maxRedirects: int=?,
  ~socketPath: string=?,
  ~proxy: proxy=?,
  unit,
) => config

let axios: (~url: string=?,~config: config=?,()) => promise<response<'data>>
let get: (~url: string, ~config: config=?, ()) => promise<response<'responseData>>
let post: (~url: string, ~data: 'requestData=?, ~config: config=?,()) => promise<response<'responseData>>
let request: (~config: config) => promise<response<'responseData>>
let head: (~url: string, ~config: config=?, ()) => promise<response<'responseData>>
let options: (~url: string, ~config: config=?, ()) => promise<response<'responseData>>
let put: (~url: string, ~data: 'requestData=?, ~config: config=?,()) => promise<response<'responseData>>
let delete: (~url: string, ~config: config=?, ()) => promise<response<'responseData>>
let patch: (~url: string, ~data: 'requestData=?, ~config: config=?, ()) => promise<response<'responseData>>

let useRequestInterceptor: ('config => promise<'updatedConfig>) => unit
let useResponseInterceptor: ('response => promise<'updatedResponse>) => unit