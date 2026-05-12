(************************************************************************)
(*         *      The Rocq Prover / The Rocq Development Team           *)
(*  v      *         Copyright INRIA, CNRS and contributors             *)
(* <O___,, * (see version control and CREDITS file for authors & dates) *)
(*   \VV/  **************************************************************)
(*    //   *    This file is distributed under the terms of the         *)
(*         *     GNU Lesser General Public License Version 2.1          *)
(*         *     (see LICENSE file for the text of the license)         *)
(************************************************************************)

open Environ
open Pattern

(***********************************************************************
  s Call-by-value reduction of patterns *)

(** Entry point for cbv normalization of a pattern *)
type cbv_pattern_infos

val create_cbv_pattern_infos : RedFlags.reds -> strong:bool -> env -> Evd.evar_map -> cbv_pattern_infos
val cbv_norm_pattern         : cbv_pattern_infos -> constr_pattern -> constr_pattern
