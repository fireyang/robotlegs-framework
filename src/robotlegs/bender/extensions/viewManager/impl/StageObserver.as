//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.viewManager.impl
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	public class StageObserver
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _registry:ContainerRegistry;

		private var _filter:RegExp = /^mx\.|^spark\.|^flash\./;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function StageObserver(containerRegistry:ContainerRegistry)
		{
			_registry = containerRegistry;
			// We only care about roots
			_registry.addEventListener(ContainerRegistryEvent.ROOT_CONTAINER_ADD, onRootContainerAdd);
			_registry.addEventListener(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE, onRootContainerRemove);
			// We might have arrived late on the scene
			for each (var binding:ContainerBinding in _registry.rootBindings)
			{
				addRootListener(binding.container);
			}
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function destroy():void
		{
			_registry.removeEventListener(ContainerRegistryEvent.ROOT_CONTAINER_ADD, onRootContainerAdd);
			_registry.removeEventListener(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE, onRootContainerRemove);
			for each (var binding:ContainerBinding in _registry.rootBindings)
			{
				removeRootListener(binding.container);
			}
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function onRootContainerAdd(event:ContainerRegistryEvent):void
		{
			addRootListener(event.container);
		}

		private function onRootContainerRemove(event:ContainerRegistryEvent):void
		{
			removeRootListener(event.container);
		}

		private function addRootListener(container:DisplayObjectContainer):void
		{
			// The magical, but extremely expensive, capture-phase ADDED_TO_STAGE listener
			container.addEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage, true);
		}

		private function removeRootListener(container:DisplayObjectContainer):void
		{
			container.removeEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage, true);
		}

		private function onViewAddedToStage(event:Event):void
		{
			const view:DisplayObject = event.target as DisplayObject;
			const qcn:String = getQualifiedClassName(view);
			const filtered:Boolean = _filter.test(qcn);
			if (filtered)
				return;
			const type:Class = view['constructor'];
			// Walk upwards from the nearest binding
			var binding:ContainerBinding = _registry.findParentBinding(view);
			while (binding)
			{
				binding.handleView(view, type);
				binding = binding.parent;
			}
		}
	}
}
