(************************************************************************)
(*         *      The Rocq Prover / The Rocq Development Team           *)
(*  v      *         Copyright INRIA, CNRS and contributors             *)
(* <O___,, * (see version control and CREDITS file for authors & dates) *)
(*   \VV/  **************************************************************)
(*    //   *    This file is distributed under the terms of the         *)
(*         *     GNU Lesser General Public License Version 2.1          *)
(*         *     (see LICENSE file for the text of the license)         *)
(************************************************************************)

(** This module implements pattern-matching on terms *)

open Names
open Constr
open EConstr
open Environ
open Pattern
open Ltac_pretype

type binding_bound_vars = Id.Set.t

(** [PatternMatchingFailure] is the exception raised when pattern
  matching fails *)
exception PatternMatchingFailure

(** [special_meta] is the default name of the meta holding the
   surrounding context in subterm matching *)
val special_meta : metavariable

(** [bound_ident_map] represents the result of matching binding
   identifiers of the pattern with the binding identifiers of the term
   matched *)
type bound_ident_map = Id.t Id.Map.t

(** [matches pat c] matches [c] against [pat] and returns the resulting
   assignment of metavariables; it raises [PatternMatchingFailure] if
   not matchable; bindings are given in increasing order based on the
   numbers given in the pattern *)
val matches : env -> Evd.evar_map -> constr_pattern -> constr -> patvar_map

(** [matches_head pat c] does the same as [matches pat c] but accepts
    [pat] to match an applicative prefix of [c] *)
val matches_head : env -> Evd.evar_map -> constr_pattern -> constr -> patvar_map

(** [extended_matches pat c] also returns the names of bound variables
   in [c] that matches the bound variables in [pat]; if several bound
   variables or metavariables have the same name, the metavariable,
   or else the rightmost bound variable, takes precedence *)
val extended_matches :
  env -> Evd.evar_map -> binding_bound_vars * constr_pattern ->
  constr -> bound_ident_map * extended_patvar_map

(** [is_matching pat c] just tells if [c] matches against [pat] *)
val is_matching : env -> Evd.evar_map -> constr_pattern -> constr -> bool

(** [is_matching_head pat c] just tells if [c] or an applicative
    prefix of it matches against [pat] *)
val is_matching_head : env -> Evd.evar_map -> constr_pattern -> constr -> bool

type context

val empty_context : context
val repr_context : context -> EConstr.t
val instantiate_context : context -> EConstr.t -> EConstr.t

(** [is_matching_appsubterm pat c] tells if a subterm of [c] matches
   against [pat] taking partial subterms into consideration *)
val is_matching_appsubterm : ?unfolded_definition_cache:bool KerName.Map.t ref option -> env -> Evd.evar_map -> constr_pattern -> constr -> bool
