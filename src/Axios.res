type config

type response<'data> = {
    data: 'data,
    status: int,
    statusText: string,
    headers: Js.Dict.t<string>,
    config: config,
    request: Js.Dict.t<string>
}

type adapter<'a> = config => Promise.t<response<'a>>
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

@obj
external makeConfig: (
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
) => config = ""

type error<'responseData,'requestData> = {
  response: option<response<'responseData>>,
  request: option<'requestData>,
  message: string
}

@module("axios")
external axios1: (~url: string=?,~config: config=?,()) => Promise.t<response<'data>> = "default"

type axiosMethods<'requestData, 'responseData> = {
    get: (~url: string, ~config: config=?, ()) => Promise.t<response<'responseData>>,
    post: (~url: string, ~data: 'requestData=?, ~config: config=?,()) => Promise.t<response<'responseData>>,
    request: (~config: config) => Promise.t<response<'responseData>>,
    head: (~url: string, ~config: config=?, ()) => Promise.t<response<'responseData>>,
    options: (~url: string, ~config: config=?, ()) => Promise.t<response<'responseData>>,
    put: (~url: string, ~data: 'requestData=?, ~config: config=?,()) => Promise.t<response<'responseData>>,
    delete: (~url: string, ~config: config=?, ()) => Promise.t<response<'responseData>>,
    patch: (~url: string, ~data: 'requestData=?, ~config: config=?, ()) => Promise.t<response<'responseData>>
}

@module("axios")
external axios0: axiosMethods<'requestData, 'responseData> = "default"

let request = axios0.request
let head = axios0.head
let options = axios0.options
let delete = axios0.delete
let patch = axios0.patch
let put = axios0.put
let get = axios0.get
let post = axios0.post
let axios = axios1



type interceptorsResponse<'response,'updatedResponse> = {
  use: ('response => Promise.t<'updatedResponse>) => unit
}

type interceptorsRequest<'config,'updatedConfig> = {
  use: ('config => Promise.t<'updatedConfig>) => unit
}

type interceptors<'config,'updatedConfig,'response,'updatedResponse> = {
  request: interceptorsRequest<'config,'updatedConfig>,
  response: interceptorsResponse<'response,'updatedResponse>
}
type axiosInterceptors<'config,'updatedConfig,'response,'updatedResponse> = {
  interceptors: interceptors<'config,'updatedConfig,'response,'updatedResponse>
}

@module("axios")
external axios2: axiosInterceptors<'config,'updatedConfig,'response,'updatedResponse> = "default"


let useRequestInterceptor = axios2.interceptors.request.use
let useResponseInterceptor = axios2.interceptors.response.use
