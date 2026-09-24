(* Workspaces differing only in their load path must not share a hash *)

let workspace unix_path =
  let vo_path =
    { Loadpath.unix_path
    ; coq_path = Libnames.dirpath_of_string "Proj"
    ; implicit = true
    ; installed = false
    ; recursive = true
    }
  in
  let cmdline =
    { Coq.Workspace.CmdLine.coqlib = "/coqlib"
    ; findlib_config = None
    ; ocamlpath = []
    ; vo_load_path = [ vo_path ]
    ; args = []
    ; require_libraries = []
    }
  in
  Coq.Workspace.default ~debug:false ~cmdline

let () =
  let a = workspace "/a" in
  let b = workspace "/b" in
  assert (Coq.Workspace.compare a b <> 0);
  assert (Coq.Workspace.hash a <> Coq.Workspace.hash b)
