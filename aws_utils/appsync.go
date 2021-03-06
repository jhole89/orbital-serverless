package utils

import (
	"bytes"
	"encoding/json"
)

type AppSyncEvent struct {
	Arguments map[string]string      `json:"arguments"`
	Identity  map[string]interface{} `json:"identity"`
	Info      struct {
		FieldName           string            `json:"fieldName"`
		ParentTypeName      string            `json:"parentTypeName"`
		SelectionSetGraphQL string            `json:"selectionSetGraphQL"`
		SelectionSetList    []string          `json:"selectionSetList"`
		Variables           map[string]string `json:"variables"`
	}
	Prev    string `json:"prev"`
	Request struct {
		Headers struct {
			Accept                    string `json:"accept"`
			AcceptEncoding            string `json:"accept-encoding"`
			AcceptLanguage            string `json:"accept-language"`
			CloudfrontForwardedProto  string `json:"cloudfront-forwarded-proto"`
			CloudfrontIsDesktopViewer string `json:"cloudfront-is-desktop-viewer"`
			CloudfrontIsMobileViewer  string `json:"cloudfront-is-mobile-viewer"`
			CloudfrontIsSmarttvViewer string `json:"cloudfront-is-smarttv-viewer"`
			CloudfrontViewerCountry   string `json:"cloudfront-viewer-country"`
			CloudfrontIsTabletViewer  string `json:"cloudfront-is-tablet-viewer"`
			ContentLength             string `json:"content-length"`
			ContentType               string `json:"content-type"`
			Host                      string `json:"host"`
			Origin                    string `json:"origin"`
			Referer                   string `json:"Referer"`
			SecFetchDest              string `json:"sec-fetch-dest"`
			SecFetchMode              string `json:"sec-fetch-mode"`
			SecFetchSite              string `json:"sec-fetch-site"`
			UserAgent                 string `json:"user-agent"`
			Via                       string `json:"via"`
			XAmzCfID                  string `json:"x-amz-cf-id"`
			XAmzUserAgent             string `json:"x-amz-user-agent"`
			XAmznTraceID              string `json:"x-amzn-trace-id"`
			XApiKey                   string `json:"x-api-key"`
			XForwardedFor             string `json:"x-forwarded-for"`
			XForwardedPort            string `json:"x-forwarded-port"`
			XForwardedProto           string `json:"x-forwarded-proto"`
		}
	}
	Source string            `json:"source"`
	Stash  map[string]string `json:"stash"`
}

func (a *AppSyncEvent) FromJson(i interface{}) error {

	eventJson, err := json.MarshalIndent(i, "", "    ")

	if err != nil {
		return err
	}

	r := bytes.NewReader(eventJson)
	return json.NewDecoder(r).Decode(a)
}
