func Test(t *testing.T) {
	tests := []struct {
		name      string
		body      map[string]any
		urlparams map[string]any
		query     map[string]any
		wantCode  int
		want      string
		wantErr   string
	}{
		{
			name: "ok",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			r := ctest.New(t).BodyJSON(tt.body)

			rr, err := r.(newHandler(r.DB).)
			ztest.Code(t, rr, tt.wantCode)
			if !ztest.ErrorContains(err, tt.wantErr) {
				t.Fatalf("wrong error:\nhave: %s\nwant: %s", err, tt.wantErr)
			}

			if d := ztest.DiffMatch(rr.Body.String(), tt.want, ztest.DiffJSON); d != "" {
				t.Error(d)
			}
		})
	}
}

