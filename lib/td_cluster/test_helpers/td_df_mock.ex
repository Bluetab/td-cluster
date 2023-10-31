defmodule TdCluster.TestHelpers.TdDfMock do
  @moduledoc """
  Mocks Clusters for tests
  """

  def get_template_by_name!(expect, name, expected, times \\ 1),
    do:
      expect.(
        MockClusterHandler,
        :call,
        times,
        fn :df, TdDf.Templates, :get_template_by_name!, [arg]
           when arg == name ->
          expected
        end
      )

  def list_templates_by_scope(expect, scope, expected),
    do:
      expect.(
        MockClusterHandler,
        :call,
        1,
        fn :df, TdDf.Templates, :list_templates_by_scope, [arg]
           when arg == scope ->
          expected
        end
      )

  def get_template(expect, template_id, expected),
    do:
      expect.(
        MockClusterHandler,
        :call,
        1,
        fn :df, TdDf.Templates, :get_template, [arg]
           when arg == template_id ->
          expected
        end
      )
end
