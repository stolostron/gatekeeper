//go:build !ignore_autogenerated

/*

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// Code generated by controller-gen. DO NOT EDIT.

package v1alpha1

import (
	"github.com/open-policy-agent/gatekeeper/v3/apis/status/v1beta1"
	"github.com/open-policy-agent/gatekeeper/v3/pkg/mutation/match"
	"k8s.io/apimachinery/pkg/runtime"
)

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ExpansionTemplate) DeepCopyInto(out *ExpansionTemplate) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	in.Status.DeepCopyInto(&out.Status)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ExpansionTemplate.
func (in *ExpansionTemplate) DeepCopy() *ExpansionTemplate {
	if in == nil {
		return nil
	}
	out := new(ExpansionTemplate)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *ExpansionTemplate) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ExpansionTemplateList) DeepCopyInto(out *ExpansionTemplateList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]ExpansionTemplate, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ExpansionTemplateList.
func (in *ExpansionTemplateList) DeepCopy() *ExpansionTemplateList {
	if in == nil {
		return nil
	}
	out := new(ExpansionTemplateList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *ExpansionTemplateList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ExpansionTemplateSpec) DeepCopyInto(out *ExpansionTemplateSpec) {
	*out = *in
	if in.ApplyTo != nil {
		in, out := &in.ApplyTo, &out.ApplyTo
		*out = make([]match.ApplyTo, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
	out.GeneratedGVK = in.GeneratedGVK
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ExpansionTemplateSpec.
func (in *ExpansionTemplateSpec) DeepCopy() *ExpansionTemplateSpec {
	if in == nil {
		return nil
	}
	out := new(ExpansionTemplateSpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ExpansionTemplateStatus) DeepCopyInto(out *ExpansionTemplateStatus) {
	*out = *in
	if in.ByPod != nil {
		in, out := &in.ByPod, &out.ByPod
		*out = make([]v1beta1.ExpansionTemplatePodStatusStatus, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ExpansionTemplateStatus.
func (in *ExpansionTemplateStatus) DeepCopy() *ExpansionTemplateStatus {
	if in == nil {
		return nil
	}
	out := new(ExpansionTemplateStatus)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *GeneratedGVK) DeepCopyInto(out *GeneratedGVK) {
	*out = *in
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new GeneratedGVK.
func (in *GeneratedGVK) DeepCopy() *GeneratedGVK {
	if in == nil {
		return nil
	}
	out := new(GeneratedGVK)
	in.DeepCopyInto(out)
	return out
}
