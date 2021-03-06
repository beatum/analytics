defmodule PlausibleWeb.Api.StatsController.OperatingSystemsTest do
  use PlausibleWeb.ConnCase
  import Plausible.TestUtils

  describe "GET /api/stats/:domain/operating_systems" do
    setup [:create_user, :log_in, :create_site]

    test "returns operating systems by new visitors", %{conn: conn, site: site} do
      conn = get(conn, "/api/stats/#{site.domain}/operating-systems?period=day&date=2019-01-01")

      assert json_response(conn, 200) == [
               %{"name" => "Mac", "count" => 2, "percentage" => 67},
               %{"name" => "Android", "count" => 1, "percentage" => 33}
             ]
    end
  end

  describe "GET /api/stats/:domain/operating-system-versions" do
    setup [:create_user, :log_in, :create_site]

    test "returns top OS versions by unique visitors", %{conn: conn, site: site} do
      filters = Jason.encode!(%{os: "Mac"})
      conn = get(conn, "/api/stats/#{site.domain}/browser-versions?period=day&date=2019-01-01")

      assert json_response(conn, 200) == [
               %{"name" => "10.15", "count" => 2, "percentage" => 100}
             ]
    end
  end
end
